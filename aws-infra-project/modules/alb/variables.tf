variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "tg_frontend_port" {
  description = "Frontend application port"
  type        = number
  default     = 3000
}

variable "tg_backend_port" {
  description = "Backend application port"
  type        = number
  default     = 5001
}

variable "frontend_path" {
  description = "Path pattern for frontend routing"
  type        = string
  default     = "/"
}

variable "backend_path" {
  description = "Path pattern for backend routing"
  type        = string
  default     = "/api/*"
}

variable "backend_health_path" {
  description = "Health check path for backend target group"
  type        = string
  default     = "/api/products"
}
